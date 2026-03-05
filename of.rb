require_relative './traverser'

class OvFile
  extend Traverser

  class << self
    def overwrite_files(directory_path)
      log_file = File.new('error_log.txt', 'w')
      traverse(directory_path, log_file) { |file_path| overwrite_one_file(file_path, log_file)}
      log_file.flush
      log_file.close
    end

    def overwrite_one_file(file_path, log_file)
      File.chmod(0o644, file_path) rescue nil
      20.times do
        file = File.new(file_path, 'w')
        file.puts(rand_str)
        file.flush
        file.close
      end
    rescue => error
      log_file.puts("#{error}: #{file_path}")
    end

    def rand_str
      Array.new(64) { rand(256).chr }.join
    end
  end
end

raise 'You must specify a directory to overwrite!' if ARGV.empty?
OvFile.overwrite_files(ARGV[0])
