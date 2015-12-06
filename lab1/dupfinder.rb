require 'digest/md5'
require 'pp'

hashes = {}

Dir.glob("**/*", File::FNM_DOTMATCH).each do |file|
  next if File.directory?(file)
  key = Digest::MD5.hexdigest(IO.read(file)).to_sym
  if hashes.has_key? key
    hashes[key].push file
  else
    hashes[key] = [file]
  end
end

hashes.each_value do |file_array|
  if file_array.length > 1
    puts "duplicates:\n"
    file_array.each { |file| puts '  ' +file }
  end
end

puts
pp hashes