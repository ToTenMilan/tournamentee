# frozen_string_literal: true

module ResultsRandomizer
  def random_result
    imitate_probable_result = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 6, 7, 8, 9]
    imitate_probable_result[rand(imitate_probable_result.size)]
  end
end
