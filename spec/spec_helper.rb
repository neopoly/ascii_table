require "minitest/autorun"

require "ascii_table"

class FakeStdin < StringIO
  def self.[](*args)
    new(args.join("\n"))
  end

  def tty?
    @tty ||= false
  end

  def tty!
    @tty = true
    self
  end
end

Minitest::Spec.class_eval do
  def ascii_table(args, stdin=FakeStdin[%w(a b)])
    AsciiTable.new(Array(args), stdin)
  end

  def fixture(name)
    name = File.join(File.dirname(__FILE__), "fixtures", name)
    FakeStdin[File.read(name)]
  end

  def assert_abort_with(regexp)
    e = assert_raises AsciiTable::AbortError do
      yield
    end
    assert_match regexp, e.message
  end
end
