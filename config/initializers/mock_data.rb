# Mock data for the application when running without a database

# Define a simple OpenStruct class to mimic ActiveRecord models
class MockRecord
  attr_accessor :id, :attributes
  
  def initialize(attributes = {})
    @attributes = attributes
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value)
      self.class.send(:attr_accessor, key)
    end
  end
  
  def [](attr)
    send(attr)
  end
  
  def method_missing(method, *args)
    if @attributes.key?(method.to_s)
      @attributes[method.to_s]
    else
      super
    end
  end
  
  def respond_to_missing?(method, include_private = false)
    @attributes.key?(method.to_s) || super
  end
  
  # Add ActiveRecord-like methods
  def save!
    true
  end
  
  def save
    true
  end
  
  def update(params)
    params.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
    true
  end
  
  def destroy
    true
  end
  
  def increment(field)
    current_value = send(field)
    send("#{field}=", current_value + 1)
    self
  end
  
  def decrement(field)
    current_value = send(field)
    send("#{field}=", current_value - 1)
    self
  end
end

# Mock data for various models
MOCK_DATA = {
  students: [
    MockRecord.new(
      id: 1, 
      email: 'student@example.com', 
      name: 'John Student', 
      password: 'password', 
      encrypted_password: '$2a$12$K4e5GZc9NLSoHPXQ9W4rz.9PNU8yeWnXqLd1pfCtR7BnB6QiN3XNq', # 'password'
      education_level: 'Graduate',
      university: 'Example University',
      max_book_allowed: 5
    )
  ],
  
  librarians: [
    MockRecord.new(
      id: 1, 
      email: 'librarian@example.com', 
      name: 'Jane Librarian', 
      password: 'password', 
      encrypted_password: '$2a$12$K4e5GZc9NLSoHPXQ9W4rz.9PNU8yeWnXqLd1pfCtR7BnB6QiN3XNq', # 'password'
      library: 'Main Library',
      university: 'Example University'
    )
  ],
  
  admins: [
    MockRecord.new(
      id: 1, 
      email: 'admin@example.com', 
      name: 'Admin User', 
      password: 'password', 
      encrypted_password: '$2a$12$K4e5GZc9NLSoHPXQ9W4rz.9PNU8yeWnXqLd1pfCtR7BnB6QiN3XNq' # 'password'
    )
  ],
  
  libraries: [
    MockRecord.new(
      id: 1,
      name: 'Main Library',
      university: 'Example University',
      location: 'Building A',
      max_days: 14,
      overdue_fines: 0.50,
      borrow_limit: 14
    ),
    MockRecord.new(
      id: 2,
      name: 'Science Library',
      university: 'Example University',
      location: 'Building B',
      max_days: 7,
      overdue_fines: 1.00,
      borrow_limit: 7
    )
  ],
  
  books: [
    MockRecord.new(
      id: 1,
      isbn: '9780451524935',
      title: '1984',
      author: 'George Orwell',
      authors: 'George Orwell',
      language: 'English',
      published: '1949',
      edition: 'Reprint',
      image: 'book1.jpg',
      subject: 'Fiction',
      summary: 'Dystopian novel about totalitarianism',
      special: false,
      special_collection: false,
      category: 'Fiction',
      count: 3,
      library_id: 1
    ),
    MockRecord.new(
      id: 2,
      isbn: '9780618640157',
      title: 'The Lord of the Rings',
      author: 'J.R.R. Tolkien',
      authors: 'J.R.R. Tolkien',
      language: 'English',
      published: '1954',
      edition: 'Illustrated',
      image: 'book2.jpg',
      subject: 'Fantasy',
      summary: 'Epic fantasy adventure',
      special: false,
      special_collection: false,
      category: 'Fantasy',
      count: 2,
      library_id: 1
    ),
    MockRecord.new(
      id: 3,
      isbn: '9780262033848',
      title: 'Introduction to Algorithms',
      author: 'Thomas H. Cormen',
      authors: 'Thomas H. Cormen',
      language: 'English',
      published: '2009',
      edition: 'Third',
      image: 'book3.jpg',
      subject: 'Computer Science',
      summary: 'Comprehensive textbook on algorithms',
      special: true,
      special_collection: true,
      category: 'Computer Science',
      count: 1,
      library_id: 2
    )
  ],
  
  checkouts: [
    MockRecord.new(
      id: 1,
      student_id: 1,
      book_id: 1,
      issue_date: Time.now - 7.days,
      return_date: Time.now + 7.days,
      validity: 14
    )
  ],
  
  hold_requests: [
    MockRecord.new(
      id: 1,
      student_id: 1,
      book_id: 3
    )
  ],
  
  bookmarks: [
    MockRecord.new(
      id: 1,
      student_id: 1,
      book_id: 2
    )
  ]
}

# Mock the schema_migrations table to prevent PendingMigrationError
MOCK_DATA[:schema_migrations] = [
  MockRecord.new(version: '20230101000000')
]

# Mock classes to replace ActiveRecord models
unless defined?(Student)
  class Student < MockRecord
    def self.find(id)
      MOCK_DATA[:students].find { |s| s.id == id }
    end
    
    def self.find_by(params)
      MOCK_DATA[:students].find do |s|
        params.all? { |k, v| s.send(k) == v }
      end
    end
    
    def self.select(field)
      OpenStruct.new(
        where: lambda { |params| 
          OpenStruct.new(
            education_level: 'Graduate',
            university: 'Example University'
          )
        }
      )
    end
    
    def self.all
      MOCK_DATA[:students]
    end
    
    def valid_password?(password)
      password == 'password' # For simplicity, any user can log in with 'password'
    end
  end
  
  class Librarian < MockRecord
    def self.find(id)
      MOCK_DATA[:librarians].find { |l| l.id == id }
    end
    
    def self.find_by(params)
      MOCK_DATA[:librarians].find do |l|
        params.all? { |k, v| l.send(k) == v }
      end
    end
    
    def self.all
      MOCK_DATA[:librarians]
    end
    
    def valid_password?(password)
      password == 'password'
    end
  end
  
  class Admin < MockRecord
    def self.find(id)
      MOCK_DATA[:admins].find { |a| a.id == id }
    end
    
    def self.find_by(params)
      MOCK_DATA[:admins].find do |a|
        params.all? { |k, v| a.send(k) == v }
      end
    end
    
    def self.all
      MOCK_DATA[:admins]
    end
    
    def valid_password?(password)
      password == 'password'
    end
  end
  
  class Library < MockRecord
    def self.find(id)
      MOCK_DATA[:libraries].find { |l| l.id == id }
    end
    
    def self.select(field)
      OpenStruct.new(
        where: lambda { |params| [1, 2] }
      )
    end
    
    def self.all
      MOCK_DATA[:libraries]
    end
  end
  
  class Book < MockRecord
    def self.find(id)
      MOCK_DATA[:books].find { |b| b.id == id }
    end
    
    def self.find_by(params)
      MOCK_DATA[:books].find do |b|
        params.all? { |k, v| b.send(k) == v }
      end
    end
    
    def self.where(params)
      if params.is_a?(Hash)
        MOCK_DATA[:books].select do |b|
          params.all? do |k, v|
            if v.is_a?(Array)
              v.include?(b.send(k))
            else
              b.send(k) == v
            end
          end
        end
      else
        MOCK_DATA[:books]
      end
    end
    
    def self.all
      MOCK_DATA[:books]
    end
    
    def library
      Library.find(self.library_id)
    end
    
    def cover?
      false
    end
    
    def cover
      OpenStruct.new(
        url: lambda { nil }
      )
    end
    
    def self.select(field)
      OpenStruct.new(
        where: lambda { |params| [1, 2, 3] }
      )
    end
    
    def self.new(params = {})
      book = MockRecord.new(
        id: MOCK_DATA[:books].size + 1,
        isbn: params[:isbn] || '0000000000000',
        title: params[:title] || 'New Book',
        author: params[:author] || params[:authors] || 'Unknown',
        authors: params[:authors] || params[:author] || 'Unknown',
        language: params[:language] || 'English',
        published: params[:published] || '2023',
        edition: params[:edition] || 'First',
        subject: params[:subject] || 'General',
        summary: params[:summary] || 'No summary available',
        special: params[:special_collection] || false,
        special_collection: params[:special_collection] || false,
        category: params[:category] || 'Uncategorized',
        count: params[:count] || 1,
        library_id: params[:library_id] || 1
      )
      MOCK_DATA[:books] << book
      book
    end
  end
  
  class Checkout < MockRecord
    def self.find(id)
      MOCK_DATA[:checkouts].find { |c| c.id == id }
    end
    
    def self.where(params)
      if params.is_a?(Hash)
        result = MOCK_DATA[:checkouts].select do |c|
          params.all? do |k, v|
            if v.nil? && k.to_s == 'return_date'
              c.return_date.nil?
            elsif v.is_a?(Array)
              v.include?(c.send(k))
            else
              c.send(k) == v
            end
          end
        end
        result.empty? ? [] : result
      else
        []
      end
    end
    
    def self.where_not(params)
      []
    end
    
    def self.all
      MOCK_DATA[:checkouts]
    end
    
    def book
      Book.find(self.book_id)
    end
    
    def student
      Student.find(self.student_id)
    end
    
    def self.select(field)
      OpenStruct.new(
        where: lambda { |params| [] }
      )
    end
    
    def self.new(params = {})
      checkout = MockRecord.new(
        id: MOCK_DATA[:checkouts].size + 1,
        student_id: params[:student_id] || 1,
        book_id: params[:book_id] || 1,
        issue_date: params[:issue_date] || Time.now,
        return_date: params[:return_date],
        validity: params[:validity] || 14
      )
      checkout
    end
  end
  
  class HoldRequest < MockRecord
    def self.find(id)
      MOCK_DATA[:hold_requests].find { |h| h.id == id }
    end
    
    def self.where(params)
      if params.is_a?(Hash)
        MOCK_DATA[:hold_requests].select do |h|
          params.all? do |k, v|
            if v.is_a?(Array)
              v.include?(h.send(k))
            else
              h.send(k) == v
            end
          end
        end
      else
        []
      end
    end
    
    def self.all
      MOCK_DATA[:hold_requests]
    end
    
    def book
      Book.find(self.book_id)
    end
    
    def student
      Student.find(self.student_id)
    end
    
    def self.select(field)
      OpenStruct.new(
        where: lambda { |params| [] }
      )
    end
    
    def self.new(params = {})
      hold = MockRecord.new(
        id: MOCK_DATA[:hold_requests].size + 1,
        student_id: params[:student_id] || 1,
        book_id: params[:book_id] || 1
      )
      hold
    end
  end
  
  class Bookmark < MockRecord
    def self.find(id)
      MOCK_DATA[:bookmarks].find { |b| b.id == id }
    end
    
    def self.where(params)
      if params.is_a?(Hash)
        MOCK_DATA[:bookmarks].select do |b|
          params.all? do |k, v|
            if v.is_a?(Array)
              v.include?(b.send(k))
            else
              b.send(k) == v
            end
          end
        end
      else
        []
      end
    end
    
    def self.all
      MOCK_DATA[:bookmarks]
    end
    
    def book
      Book.find(self.book_id)
    end
    
    def student
      Student.find(self.student_id)
    end
    
    def self.select(field)
      OpenStruct.new(
        where: lambda { |params| [] }
      )
    end
    
    def self.new(params = {})
      bookmark = MockRecord.new(
        id: MOCK_DATA[:bookmarks].size + 1,
        student_id: params[:student_id] || 1,
        book_id: params[:book_id] || 1
      )
      bookmark
    end
  end
  
  class SpecialBook < MockRecord
    def self.where(params)
      []
    end
    
    def self.all
      []
    end
    
    def self.new(params = {})
      special = MockRecord.new(
        id: 1,
        student_id: params[:student_id] || 1,
        book_id: params[:book_id] || 1
      )
      special
    end
  end
  
  class Transaction < MockRecord
    def self.where(params)
      []
    end
    
    def self.find_or_initialize_by(params)
      OpenStruct.new(
        update_attributes!: lambda { |params| true }
      )
    end
  end
  
  # Mock schema_migrations to prevent PendingMigrationError
  class SchemaMigration < MockRecord
    def self.find(id)
      MOCK_DATA[:schema_migrations].find { |s| s.id == id }
    end
    
    def self.all
      MOCK_DATA[:schema_migrations]
    end
    
    def self.table_exists?
      true
    end
    
    def self.create_table
      true
    end
  end
  
  # Mock ActiveRecord::Migrator to prevent migration errors
  unless defined?(ActiveRecord)
    module ActiveRecord
      class Base
        def self.establish_connection(*args)
          # Do nothing
        end
        
        def self.connection
          OpenStruct.new(
            execute: lambda { |sql| [] },
            select_values: lambda { |sql| [] }
          )
        end
      end
      
      class Migration
        def self.check_pending!
          # Do nothing
        end
        
        class CheckPending
          # Empty class to prevent NoMethodError
        end
      end
      
      class Migrator
        def self.needs_migration?
          false
        end
      end
      
      module Tasks
        class DatabaseTasks
          def self.migrate
            # Do nothing
          end
        end
      end
      
      class PendingMigrationError < StandardError
        # Mock exception
      end
    end
  end
  
  # Mock mailer
  class UserMailer
    def self.checkout_email(user, book)
      OpenStruct.new(
        deliver_now: lambda { true },
        deliver_later: lambda { true }
      )
    end
    
    def self.returnbook_email(user, book)
      OpenStruct.new(
        deliver_now: lambda { true },
        deliver_later: lambda { true }
      )
    end
    
    def self.bookmark_email(user, book)
      OpenStruct.new(
        deliver_now: lambda { true },
        deliver_later: lambda { true }
      )
    end
  end
end 