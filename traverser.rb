module Traverser
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
end
