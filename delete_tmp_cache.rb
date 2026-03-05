require_relative './traverser'
require 'fileutils'

class DeleteTmpCache
  extend Traverser

  class << self
    def delete_dirs(directory_path)
      log_file = File.new('error_log.txt', 'w')
      traverse_dir(directory_path, log_file) { |file_path| delete_one_dir(file_path, log_file)}
      log_file.flush
      log_file.close
    end

    def delete_one_dir(file_path, log_file)
      return unless ( file_path =~ /(tmp\/cache)$/ || file_path =~ /\/node_modules$/ )
      puts("Deleting #{file_path} ...")
      #FileUtils.remove_entry_secure("#{file_path}/*")
      system("rm -rf #{file_path}/*")
    rescue => error
      log_file.puts("#{error}: #{file_path}")
    end
  end
end


raise 'You must run this program as root!' if Process.euid != 0
raise 'You must specify a directory to delete tmp/cache directories!' if ARGV.empty?
DeleteTmpCache.delete_dirs(ARGV[0])
