class OvFile
  class << self
    def traverse(directory_path, &block)
      Dir.foreach(directory_path) do |filename|
        file_path = File.join(directory_path, filename)
        if File.file?(file_path)
          puts("Processing #{file_path}")
          yield file_path
        elsif File.directory?(file_path)
          puts("\n\n***** Dir #{file_path}")
          traverse(file_path, &block) unless (filename =~ /^\.{1,2}$/)
        end
      end
    end

    def overwrite_files(directory_path)
      log_file = File.new('error_log.txt', 'w')
      traverse(directory_path) { |file_path| overwrite_one_file(file_path, log_file)}
      log_file.flush
      log_file.close
    end

    def overwrite_one_file(file_path, log_file)
      `chmod u+w #{file_path}`
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
      (0..63).inject('') { |result, x| result += rand(256).to_s }
    end
  end
end

raise 'You must specify a directory to overwrite!' if ARGV.empty?
OvFile.overwrite_files(ARGV[0])
