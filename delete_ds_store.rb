class DeleteDsStore
  class << self
    def traverse(directory_path, &block)
      Dir.foreach(directory_path) do |filename|
        file_path = File.join(directory_path, filename)
        if File.file?(file_path)
          yield file_path
        elsif File.directory?(file_path)
          puts("\n\n***** Dir #{file_path}")
          traverse(file_path, &block) unless (filename =~ /^\.{1,2}$/)
        end
      end
    end

    def delete_files(directory_path)
      log_file = File.new('error_log.txt', 'w')
      traverse(directory_path) { |file_path| delete_one_file(file_path, log_file)}
      log_file.flush
      log_file.close
    end

    def delete_one_file(file_path, log_file)
      return unless file_path =~ /(\.DS_Store)$/
      puts("Deleting #{file_path} ...")
      File.chmod(0o644, file_path) rescue nil
      File.delete(file_path)
    rescue => error
      log_file.puts("#{error}: #{file_path}")
    end

    def rand_str
      Array.new(64) { rand(256).chr }.join
    end
  end
end

raise 'You must specify a directory to delete .DS_Store files!' if ARGV.empty?
DeleteDsStore.delete_files(ARGV[0])
