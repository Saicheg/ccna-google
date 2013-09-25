# encoding: utf-8

url = 'https://dl.dropboxusercontent.com/u/12488517/CCNA/CCNA2-Version%203.1.html'

doc = Nokogiri::HTML(open(url))
doc.css('.entry').each do |entry|

  entry.css("p").each do |p|
    answers, right_answers = [], []

    content = p.children.to_html.gsub("\n", '').gsub('• ', '').split("<br>").map(&:strip).reject(&:blank?)

    question_text = content[0].gsub(/\A[0-9]*\.\s*/,'')
    answers_content = content[1..-1]


    answers_content.each do |answer|
      if answer =~ /strong/
        text = Nokogiri::HTML(answer).text.strip
        answers << text
        right_answers << text
      elsif answer =~ /img/
        next
      else
        answers << answer.strip
      end
    end

    puts '*' * 80
    puts "<#{question_text}>"
    answers.each do |answer|
      print '*' if right_answers.include?(answer)
      puts answer
    end
    puts '*' * 80

    question = Question.create(text: question_text)
    answers.each do |answer_text|
      correct = !!right_answers.include?(answer_text)
      Answer.create(text: answer_text, correct: correct, question_id: question.id)
    end

  end
end
