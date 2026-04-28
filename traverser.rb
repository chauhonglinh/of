module Traverser
  def traverse(directory_path, log_file, &block)

    Dir.foreach(directory_path) do |filename|
      file_path = File.join(directory_path, filename)
      if File.file?(file_path)
        puts("  ### File: #{file_path}")
        yield file_path
      elsif File.directory?(file_path)
        puts("\n\n***** Dir #{file_path}")
        traverse(file_path, log_file, &block) unless (filename =~ /^\.{1,2}$/)
      end
    end

  rescue => error
    log_file.puts("#{error} in traverse: #{directory_path}")
  end

  def traverse_dir(directory_path, log_file, &block)
    Dir.foreach(directory_path) do |filename|
      file_path = File.join(directory_path, filename)

      if File.directory?(file_path)
        puts("\n\n***** Dir #{file_path}")
        yield file_path
        traverse_dir(file_path, log_file, &block) unless (filename =~ /^\.{1,2}$/)
      end
    end

  rescue => error
    log_file.puts("#{error} in traverse_dir: #{directory_path}")
  end
end
