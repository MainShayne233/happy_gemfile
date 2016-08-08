require "happy_gemfile/version"

module HappyGemfile
    def self.alphabetize

      lines = gemfile
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

      replace_gemfile lines
    end

    def self.wipe_comments
      lines = gemfile
      lines.delete_if{|line| is_comment?(line)}
      replace_gemfile lines
    end

    # HELPERS

    def self.is_comment? line
      is? line, '#'
    end

    def self.is? line, type
      line.split(' ').first == type
    end

    def self.gemfile
      unless File.exists? "Gemfile"
        puts "There doesn't appear to be a Gemfile... not sure what to do."
        return false
      end
      File.readlines "Gemfile"
    end

    def self.replace_gemfile lines
      File.open("Gemfile", 'w') { |file| file.write(lines.join('')) }
    end
  end
