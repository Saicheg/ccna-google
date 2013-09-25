URLS = {'https://dl.dropboxusercontent.com/u/12488517/CCNA/CCNA%202%20Final%202012%20Exam%20Answers%20%E2%80%93%20V1%20%20%20CCNA%20Exploration%204.0%2C%20CCNA%20640-802%2C%20CCNA%20Answers%2C%20CCNA%20Blog.html' => 4242,
        'https://dl.dropboxusercontent.com/u/12488517/CCNA/CCNA%202%20Final%202012%20Exam%20Answers%20%E2%80%93%20V2%20%20%20CCNA%20Exploration%204.0%2C%20CCNA%20640-802%2C%20CCNA%20Answers%2C%20CCNA%20Blog.html' => 4244,
        'https://dl.dropboxusercontent.com/u/12488517/CCNA/CCNA%202%20Final%202012%20Exam%20Answers%20%E2%80%93%20V3%20%20%20CCNA%20Exploration%204.0%2C%20CCNA%20640-802%2C%20CCNA%20Answers%2C%20CCNA%20Blog.html' => 4246}

URLS.each do |url, num|

  doc = Nokogiri::HTML(open(url))
  doc.css(".post-#{num} .entry-content p").each do |p|

    answers, right_answers = [], []

    q = p.css('strong:first-child')
    question_text = q.text.gsub(/\n/,'').gsub(/\A[0-9]*\.\s*/,'')
    answers_elem = p.to_s.gsub(q.to_s, '')

    Nokogiri::HTML(answers_elem.gsub(/<br>/, "")).css('p').children.each do |elem|
      if elem.name =~ /strong/
        text = elem.text
        answers << text
        right_answers << text
      elsif elem.name =~ /text/
        elem.text.split("\n").each {|answer| answers << answer}
      end
    end

    answers.map!{|answer| answer.gsub("\n", '')}.reject!(&:blank?)
    right_answers.map!{|answer| answer.gsub("\n", '')}.reject!(&:blank?)

    puts '*' * 80
    puts "<#{question_text}>"
    answers.each do |answer|
      print '*' if right_answers.include?(answer)
      puts answer
    end
    puts '*' * 80

    next if question_text.blank?

    question = Question.create(text: question_text)
    answers.each do |answer_text|
      correct = !!right_answers.include?(answer_text)
      Answer.create(text: answer_text, correct: correct, question_id: question.id)
    end

  end
end
