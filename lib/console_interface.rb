class ConsoleInterface
  FIGURES =
    Dir[__dir__+'/../data/figures/*.txt'].
    sort.
    map {|file_name| File.read(file_name)}

  def initialize(game)
    @game = game
  end

  def print_out
    <<~END
    Слово: #{word_to_show.join(" ")}
    #{figure}
    Ошибки (#{@game.errors_made}): #{errors_to_show}
    У вас осталось ошибок: #{@game.errors_allowed}
    #{won_lost}
    END
  end

  def won_lost
    if @game.won?
      "Поздравляем! Вы выиграли"
    elsif @game.lost?
      "Вы проиграли. Загаданное слово #{@game.word}"
    end
  end

  def figure
    return FIGURES[@game.errors_made]
  end

  def word_to_show
    @game.letters_to_guess.map do |letter|
      if letter == nil
        "__"
      else
        letter
      end
    end
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  def get_input
    print "Введите следующую букву: "
    gets[0].upcase
  end
end
