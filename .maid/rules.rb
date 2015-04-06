require 'exifr'
require 'chunky_png'

Maid.rules do

  RUN_TIME = Time.now
  DAY_SECONDS = 60 * 60 * 24
  WEEK = DAY_SECONDS * 7
  ONE_WEEK_AGO = (RUN_TIME - WEEK)
  TWO_WEEKS_AGO = (RUN_TIME - WEEK * 2)
  THREE_MONTHS_AGO = (RUN_TIME - (DAY_SECONDS * 93))

  rule 'Sort Camera Uploads into Photos directory' do
    dir('~/Dropbox/Camera Uploads/*.{jpg,png,gif,JPG}').select do |path|
      taken_on = EXIFR::JPEG.new(path).date_time if File.extname(path).downcase == '.jpg'
      if taken_on && taken_on != '""'
        destination = "~/Dropbox/Photos/#{taken_on.year}/#{"%02d" % taken_on.month}/#{"%02d" % taken_on.day}/"
        FileUtils.mkdir_p destination
        move(path, destination)
      else
        @path = path.split
        @path = @path[1].split('/')[1]
        destination = "~/Dropbox/Photos/#{@path.split('-')[0].to_i}/#{"%02d" % @path.split('-')[1].to_i}/#{"%02d" % @path.split('-')[2].to_i}/"
        FileUtils.mkdir_p destination
        move(path, destination)
      end
    end
  end

  rule 'Collect Dropbox Videos into Photos directory' do
    move where_content_type(dir('~/Dropbox/Camera Uploads/'), 'video'), '~/Movies/'
    dir('~/Dropbox/Camera Uploads/*.{mkv,mp4,avi,mov}').each do |path|
      move(path, '~/Movies/')
    end
  end

  rule '/Library/Caches/Homebrew/' do
    dir('/Library/Caches/Homebrew/*.tar.*').each do |path|
      trash path if File.mtime(path) < THREE_MONTHS_AGO
    end
    dir('/Library/Caches/Homebrew/*.tgz').each do |path|
      trash path if File.mtime(path) < THREE_MONTHS_AGO
    end
    dir('/Library/Caches/Homebrew/*.tbz').each do |path|
      trash path if File.mtime(path) < THREE_MONTHS_AGO
    end
  end

  rule '~/Library/Caches' do
    dir('~/Library/Caches/Google/Chrome/Default/Cache/*').each do |path|
      trash path if File.mtime(path) < THREE_MONTHS_AGO
    end
  end

  rule 'Collect downloaded videos to watch later' do
    move where_content_type(dir('~/Downloads/*'), 'video'), '~/Movies/'
    dir('~/Downloads/*.{mkv,mp4,avi}').each do |path|
      move(path, '~/Movies/')
    end
  end

  rule 'Cleanup Downloads + Desktop' do
    ['~/Downloads', '~/Desktop'].each do |junk_drawer|
      dir("#{junk_drawer}/*").each do |path|
        if 2.week.since?(accessed_at(path))
          trash(path)
        end
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
    found = dir('~/Downloads/*.zip').select { |path|
      zipfile_contents(path).any? { |c| c.match(/\.app$/) }
    }

    trash(found)
  end

  rule 'Misc Screenshots' do
    dir('~/Desktop/Screen shot *').each do |path|
      if 1.week.since?(accessed_at(path))
        move(path, '~/Documents/Misc Screenshots/')
      end
    end
  end

  if /darwin/ =~ RUBY_PLATFORM do
    # NOTE: Currently, only Mac OS X supports `downloaded_from`.
    rule 'Old files downloaded while developing/testing' do
      dir('~/Downloads/*').each do |path|
        if downloaded_from(path).any? { |u| u.match('http://localhost') } &&
            1.week.since?(accessed_at(path))
          trash(path)
        end
      end
    end
  end

  rule 'Update crontab' do
    `whenever --update-crontab -f ~/.maid/schedule.rb`
  end
end
