require "spec_helper"

describe AsciiTable do
  describe "instance" do
    describe "with default options" do
      subject { ascii_table([]) }
      let(:options) { subject.options }

      it "has delimiter ;" do
        assert_equal ";", options.delimiter
      end

      it "has no heading" do
        assert_equal false, options.headings
      end

      it "has table aligment set to :left" do
        assert_equal :left, options.table_align
      end

      it "has no cell aligments" do
        assert_equal Hash.new, options.cell_align
      end

      it "has no separator" do
        assert_equal "", options.separator
      end
    end

    describe "parsing option" do
      describe "help" do
        it "parses short" do
          assert_abort_with /Help/ do
            ascii_table(%w(-h))
          end
        end

        it "parses long" do
          assert_abort_with /Help/ do
            ascii_table(%w(---help))
          end
        end

        it "help on invalid option" do
          assert_abort_with /Help/ do
            ascii_table(%w(---invalid-option))
          end
        end
      end

      describe "short" do
        subject { ascii_table(%w(-d , -H -A right -a 1=left,2=right -s XXX)) }
        let(:options) { subject.options }

        it "parses delimiter" do
          assert_equal ",", options.delimiter
        end

        it "parses header" do
          assert_equal true, options.header
        end

        it "parses table_align" do
          assert_equal :right, options.table_align
        end

        it "parses cell_align" do
          assert_equal Hash[1 => :left, 2 => :right], options.cell_align
        end

        it "parses separator" do
          assert_equal "XXX", options.separator
        end
      end

      describe "long" do
        subject { ascii_table(%w(--delimiter , --header --table-align right --align 1=left,2=right --separator XXX)) }
        let(:options) { subject.options }

        it "parses delimiter" do
          assert_equal ",", options.delimiter
        end

        it "parses header" do
          assert_equal true, options.header
        end

        it "parses table_align" do
          assert_equal :right, options.table_align
        end

        it "parses cell_align" do
          assert_equal Hash[1 => :left, 2 => :right], options.cell_align
        end

        it "parses separator" do
          assert_equal "XXX", options.separator
        end
      end

      describe "delimiter" do
        attr_accessor :switches
        subject { ascii_table(switches) }
        let(:options) { subject.options }

        it "parses tab" do
          self.switches = %w(-d \t)
          assert_equal "\t", options.delimiter
        end

        it "parses 2 tabs" do
          self.switches = %w(-d \t\t)
          assert_equal "\t\t", options.delimiter
        end
      end
    end

    describe "reading input" do
      it "not bound to tty" do
        assert_abort_with /Need input/ do
          ascii_table([], FakeStdin[].tty!)
        end
      end

      it "needs at least one row without headers" do
        assert_abort_with /Empty input/ do
          ascii_table([], FakeStdin[])
        end
      end

      it "needs at least one row with header" do
        assert_abort_with /Need rows/ do
          ascii_table([%(-H)], FakeStdin[%w(a)])
        end
      end
    end

    describe "generating table" do
      def self.generates(description, args, file)
        it "generates #{description}" do
          input = fixture("#{file}.csv")
          expected = fixture("#{file}.txt").read.chomp

          actual = ascii_table(args, input).to_s

          assert_equal expected, actual
        end
      end

      generates "without header", %w(), "without_header"
      generates "with header", %w(-H), "with_header"
      generates "with table_align", %w(-A right), "table_align"
      generates "with cell_align", %w(-a 2=right,3=center,4=left), "cell_align"
      generates "delimited", ["-d" "||"], "delimited"
      generates "with tab delimited", ["-d", "\\t"], "tab_delimited"
      generates "with separators", [], "separator"
    end

  end

end
