require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton   

    def initialize 
        super('questions.db')
        self.type_translation - true
        self.result_as_hash = true
    end 
end 

class Question 
    attr_accessor :question_id, :title, :body, :author_id
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map { |datum| Question.new(datum)}
    end 


    def self.find_by_id(question_id)
        question = QuestionsDatabase.instance.execute( <<-SQL, question_id)
        SELECT *
        FROM questions
        WHERE question_id = ?
        SQL
        return nil unless question.length > 0

        Question.new(question.first)
    end 

    def initialize(options)
        @question_id = options['question_id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end 


end 

