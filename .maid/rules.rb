require 'exifr'
require 'chunky_png'

Maid.rules do
  # Monitor dropbox camera uploads
  rule 'Sort Camera Uploads into Photos directory' do
    dir('~/Dropbox/Camera Uploads/*.{jpg,gif,JPG}').select do |path|
      begin
        taken_on = EXIFR::JPEG.new(path).date_time
      rescue
        move_without_exif(path)
      end

      (taken_on && taken_on != '""') ? move_with_exif(taken_on, path) : move_without_exif(path)
    end

    dir('~/Dropbox/Camera Uploads/*.{png}').select { |path| move_without_exif(path) }
  end

  rule 'Collect Dropbox Videos into Photos directory' do
    move where_content_type(dir('~/Dropbox/Camera Uploads/'), 'video'), '~/Movies/'
    dir('~/Dropbox/Camera Uploads/*.{mkv,mp4,avi,mov}').each do |path|
      move(path, '~/Dropbox/Videos/')
    end
  end

  rule '/Library/Caches/Homebrew/' do
    dir('/Library/Caches/Homebrew/*.tar.*').each do |path|
      trash path if 30.days.since?(accessed_at(path))
    end
    dir('/Library/Caches/Homebrew/*.tgz').each do |path|
      trash path if 30.days.since?(accessed_at(path))
    end
    dir('/Library/Caches/Homebrew/*.tbz').each do |path|
      trash path if 30.days.since?(accessed_at(path))
    end
  end

  rule 'Cleanup Downloads + Desktop' do
    ['~/Downloads', '~/Desktop'].each do |junk_drawer|
      dir("#{junk_drawer}/*").each do |path|
        trash(path) if 2.week.since?(accessed_at(path))
      end
    end
  end

  rule 'Linux ISOs, etc' do
    trash(dir('~/Downloads/*.iso'))
  end

  rule 'Mac OS X applications in disk images' do
    trash(dir('~/Downloads/*.dmg'))
  end

  rule 'Mac OS X applications in zip files' do
    found = dir('~/Downloads/*.zip').select do |path|
      zipfile_contents(path).any? { |c| c.match(/\.app$/) }
    end

    trash(found)
  end

  rule 'Old files downloaded while developing/testing' do
    dir('~/Downloads/*').each do |path|
      if downloaded_from(path).any? { |u| u.match('http://localhost') } && 1.week.since?(accessed_at(path))
        trash(path)
      end
    end
  end

  rule 'Misc Screenshots' do
    dir('~/Desktop/Screen shot *').each do |path|
      move(path, '~/Documents/Misc Screenshots/') if 1.week.since?(accessed_at(path))
    end
  end
end

def move_with_exif(data, path)
  destination = "~/Dropbox/Photos/#{data.year}/#{"%02d" % data.month}/#{"%02d" % data.day}/"
  mkdir destination
  move(path, destination)
end

def move_without_exif(path)
  @path = path.split
  @path = @path[1].split('/')[1]
  destination = "~/Dropbox/Photos/#{@path.split('-')[0].to_i}/#{"%02d" % @path.split('-')[1].to_i}/#{"%02d" % @path.split('-')[2].to_i}/"
  mkdir destination
  move(path, destination)
end
