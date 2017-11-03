class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(students)
    students.each do |s|
      Student.new(s)
    end
  end

  def add_student_attributes(profile)
    profile.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
