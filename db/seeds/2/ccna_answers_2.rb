# encoding: utf-8

url = 'https://dl.dropboxusercontent.com/u/12488517/CCNA/CCNA%201%20Exam%20Networking%20Answers%20%20CCNA%20Exploration%202%20-%20FINAL%20Exam%20Answers%20%28A%29%20Version%204.0.html'

doc = Nokogiri::HTML(open(url))
doc.css("#answers p").each do |p|
  answers, right_answers = [], []
  content = p.children.to_html.gsub("\n", '').gsub('• ', '').split("<br>").map(&:strip)

  question_text = content[0].gsub(/\A[0-9]*\.\s*/,'')
  answers_content = content[1..-1]

  answers_content.each do |answer|
    if answer =~ /font/
      text = Nokogiri::HTML(answer).text
      answers << text
      right_answers << text
    else
      answers << answer
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
