require 'date'

class Student
  attr_reader :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = validate_date_of_birth(date_of_birth)
    add_student(self) if @date_of_birth
  end

  def validate_date_of_birth(date_of_birth)
    date = Date.parse(date_of_birth)
    if date >= Date.today
      puts "Date of birth must be in the past: #{surname} #{name} #{date_of_birth}"
      return nil
    end
    date
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth + age.years
    age
  end

  def add_student(student)
    if @@students.any? { |s| s.surname == student.surname && s.name == student.name && s.date_of_birth == student.date_of_birth }
      puts "Student #{student.surname} #{student.name} #{student.date_of_birth} wasn`t created because it is already in the list."
    else
      @@students << student
    end
  end

  def remove_student
    @@students.delete_if { |s| s.surname == @surname && s.name == @name && s.date_of_birth == @date_of_birth }
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    @@students
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    if today.month < @date_of_birth.month || (today.month == @date_of_birth.month && today.day < @date_of_birth.day)
      age -= 1
    end
    
    age
  end

   def to_s
    "#{surname} #{name}, data birth: #{@date_of_birth}, age: #{calculate_age}"
  end
end

student1 = Student.new("Doe", "John", "2055-05-15")
student2 = Student.new("Smith", "Anna", "1998-08-22")
student3 = Student.new("Brown", "Emily", "2002-01-30")
student4 = Student.new("Doe", "John", "2000-05-15")
student5 = Student.new("Black", "John", "2000-06-15")
student6 = Student.new("Black", "John", "2000-06-15")

puts "List all students"
Student.all_students.each { |student| puts student }

puts "Students age 24"
students_age_24 = Student.get_students_by_age(24)
students_age_24.each { |student| puts student }

puts "Students name John"
students_name_John = Student.get_students_by_name("John")
students_name_John.each { |student| puts student }

puts "Remove studen 4"
student4.remove_student
puts "List all students after remove"
Student.all_students.each { |student| puts student }