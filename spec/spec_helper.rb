require 'asciidoctor-docbook45'
require 'pathname'

RSpec.configure do |config|
  def to_docbook45 input, opts = {}
    if Pathname === input
      Asciidoctor.convert_file input, (opts.merge backend: 'docbook45', safe: :safe)
    else
      Asciidoctor.convert input, (opts.merge backend: 'docbook45', safe: :safe, standalone: (opts.fetch :standalone, true))
    end
  end

  def with_memory_logger level = nil
    old_logger = Asciidoctor::LoggerManager.logger
    logger = Asciidoctor::MemoryLogger.new
    logger.level = level if level
    begin
      Asciidoctor::LoggerManager.logger = logger
      yield logger
    ensure
      Asciidoctor::LoggerManager.logger = old_logger
    end
  end
end
