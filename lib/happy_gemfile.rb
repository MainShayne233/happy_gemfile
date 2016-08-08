require "happy_gemfile/version"

module HappyGemfile

    def self.alphabetize
      unless File.exists? "Gemfile"
        puts "There doesn't appear to be a Gemfile. . . not sure what to sort."
        return false
      end

      lines = File.readlines "Gemfile"
      gem_groups = [[]]
      gem_indexes = [[]]
      group_count = 0
      in_group = false

      lines.each_with_index do |line, index|
        if line.include? 'gem' and !(line.include? "source '")
          unless in_group
            gem_groups[0] << line
            gem_indexes[0] << index
          else
            gem_groups[group_count] << line
            gem_indexes[group_count] << index
          end
        elsif line.include? 'group'
          in_group = true
          group_count += 1
          gem_groups << []
          gem_indexes << []
        elsif line.include? 'end'
          in_group = false
        end
      end

      gem_groups.map{|group| group.sort}.each_with_index do |group, group_index|
        group.each_with_index do |line, line_index|
          lines[gem_indexes[group_index][line_index]] = line
        end
      end

      File.open("Gemfile", 'w') { |file| file.write(lines.join('')) }
    end
  end
