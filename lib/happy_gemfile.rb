require "happy_gemfile/version"

module HappyGemfile

    def self.all
      gemfile = wipe_comments
      gemfile = organize_groups gemfile
      gemfile = alphabetize gemfile
      replace_gemfile gemfile
    end

    def self.alphabetize lines=nil

      lines ||= gemfile
      gem_groups = [[]]
      gem_indexes = [[]]
      group_count = 0
      in_group = false

      lines.each_with_index do |line, index|
        if is?(line, 'gem')
          unless in_group
            gem_groups[0] << line
            gem_indexes[0] << index
          else
            gem_groups[group_count] << line
            gem_indexes[group_count] << index
          end
        elsif is?(line, 'group')
          in_group = true
          group_count += 1
          gem_groups << []
          gem_indexes << []
        elsif is? line, 'end'
          in_group = false
        end
      end

      gem_groups.map{|group| group.sort}.each_with_index do |group, group_index|
        group.each_with_index do |line, line_index|
          lines[gem_indexes[group_index][line_index]] = line
        end
      end

      lines
    end

    def self.wipe_comments lines=nil
      lines ||= gemfile
      lines.delete_if{|line| is_comment?(line)}
      lines
    end

    def self.organize_groups lines=nil
      lines ||= gemfile
      groups = {general: []}
      current_group = :general
      lines.each do |line|
        if is? line, 'gem'
          groups[current_group] << line.gsub("\n", '')
        elsif is? line, 'group'
          current_group = group_name line
          groups[current_group] ||= []
        elsif is? line, 'end'
          current_group = :general
        else
          groups[:not_gems] ||= []
          groups[:not_gems] << line.gsub("\n", '')
        end
      end

      groups.each {|key, lines| lines.delete_if {|line| ["\n", ''].include? line} }

      organized = []

      groups[:not_gems].each {|line| organized << line << "\n"}

      organized << "\n"

      groups[:general].each {|line| organized << line << "\n"}

      organized << "\n"

      (groups.keys - [:general, :not_gems]).each do |group|
        organized << "group #{group_line(group)} do" << "\n"
        groups[group].each {|line| organized << "#{line}" << "\n"}
        organized << 'end' << "\n\n"
      end
      organized
    end

    # HELPERS

    def self.is_comment? line
      is? line, '#'
    end

    def self.is? line, type
      line.split(' ').first == type
    end

    def self.group_name line
      line.match(/group(.*)do/)
          .to_a[1]
          .strip.gsub(', ', '_')
          .gsub(':', '')
          .to_sym
    end

    def self.group_line group
      group.to_s.split('_').map{|g| ":#{g}"}.join(', ')
    end

    def self.gemfile
      unless File.exist? "Gemfile"
        puts "There doesn't appear to be a Gemfile... not sure what to do."
        return false
      end
      File.readlines "Gemfile"
    end

    def self.replace_gemfile lines
      File.open("Gemfile", 'w') { |file| file.write(lines.join('')) }
    end
  end
