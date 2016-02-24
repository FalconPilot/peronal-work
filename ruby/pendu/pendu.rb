# /------------------------------------------\
# |          Jeu du pendu en Ruby            |
# \------------------------------------------/

begin

# ============================================
# |         Get word list from txt           |
# ============================================

    def get_word_list
        words = ""
        File.open('mots.txt', 'r') do |file|
            while line = file.gets
                words += line
            end
        end
        list = words.split
    end

# ============================================
# |          Wait for user input             |
# ============================================

    def prompt(*args)
        print(*args)
        gets
    end

# ============================================
# |            Display content               |
# ============================================

    def display_content
        print @yel
        print "\n#{@lives} Lives left	#{@std}["
        print @gre
        @lives.times do
            print "|"
        end
        print @std
        puts "]"
        print "\nLetters used : "
        @used.each do |letter|
            print("#{letter} | ")
        end
        print("\n")
        puts word_define
    end

# ============================================
# |         Define word to display           |
# ============================================

    def word_define
        display = ""
        @word.each_with_index do |letter, i|
            if @state[i] == 1 || !letter.match(/^[[:alpha:]]$/)
                display += letter.upcase + " "
            elsif !letter.match(/^[[:alpha:]]$/)
                display += letter + " "
            else
                display += "_ "
            end
        end
        display
    end

# ============================================
# |             Define victory               |
# ============================================

    def victory?
        victory = 0
        @state.each do |s|
            victory += s
        end
        victory
    end

# ============================================
# |              Main routine                |
# ============================================

    def routine
        while @lives > 0
            if victory? == @word.size
                puts "\nVictory ! :3\n"
                return
            end
            display_content
            refresh(prompt("Chose the next letter : ")[0])
        end
        puts "\nYou lost ! :'(\n"
        print "The word was "
        @word.each do |letter|
            print letter
        end
        puts " !"
    end

# ============================================
# |            Refresh function              |
# ============================================

    def refresh(guess)
        correct = 0
        if !guess.match(/^[[:alpha:]]$/)
            puts "Incorrect character !"
            return
        end
        @used.each do |used|
            if guess == used
                puts "Letter already guessed !"
                return
            end
        end
        @word.each_with_index do |letter, i|
            if guess.upcase == letter && @state[i] == 0
                correct += 1
                @state[i] = 1
            end
        end
        if correct == 0
            @lives -= 1
        end
        @used += [guess]
    end

# ============================================
# |             Color variables              |
# ============================================

    def colors_initialize
        @gre = "\033[32m"
        @yel = "\033[33m"
        @std = "\033[39m"
    end

# ============================================
# |             Initialization               |
# ============================================

    def data_initialize
        @lives = 5
        @list = get_word_list
        @word = @list[rand(@list.size)].split(//)
        @state = Array.new(@word.size, 0)
        @word.each_with_index do |letter, i|
            @word[i] = letter.upcase
            if !letter.match(/^[[:alpha:]]$/)
                @state[i] = 1
            end
        end
        @used = []
    end

# ============================================
# |              Main program                |
# ============================================

    data_initialize
    colors_initialize
    routine

end
