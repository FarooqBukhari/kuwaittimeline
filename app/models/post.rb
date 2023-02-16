class Post < ApplicationRecord
  after_save :updateApprovedUser
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  has_and_belongs_to_many :categories
  has_many :references
  accepts_nested_attributes_for :references
  accepts_nested_attributes_for :categories

  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  has_one_attached :picture
  has_many_attached :gallery_photoes

  scope :approved, -> { where(status: :approved) }

  scope :pending, -> { where("status = 'pending'")}

  scope :flagged, -> {where("flag > 0")}

  scope :happened_today, -> {where(date: Date.today, status: :approved)}
  scope :timeline, -> {where.not(date: Date.today)}

  validates_inclusion_of :status, in: %w/pending approved rejected/
  validates_presence_of :subject_ar, :subject_en, :status, :date

  scope :with_text, ->(text) { 
    text = text.downcase
    where("LOWER(subject_ar) LIKE ? OR LOWER(subject_en) LIKE ? OR LOWER(description_en) LIKE ? OR LOWER(description_ar) LIKE ?",
     "%#{text}%", "%#{text}%", "%#{text}%", "%#{text}%") 
  }

  scope :with_category, ->(category_id) {
    category = Category.find(category_id).posts
  }

  scope :asc, lambda {order("date asc")}

  scope :desc, lambda {order("date desc")}

  def self.status_choices
    %w/pending approved rejected/
  end

  def self.import(file)
    errors = []
    success = 0
    failure = 0
    CSV.foreach(file.path, headers: true) do |row|
      post = Post.new(row.to_hash.except("category_ids", "reference"))
      if ! post.save
        failure+=1
        errors << "(Subject AR: " + post.subject_ar + "): "+ post.errors.full_messages[0]
      else 
        success+=1
        row.to_hash["category_ids"].split(",") do |cat_id|
          post.categories << Category.find_by_id(cat_id) if Category.find_by_id(cat_id) != nil
        end
        post.references.create(reference_url: row.to_hash["reference"]) if row.to_hash["reference"].present?
      end
    end
    [errors,success,failure]
  end

  def updateApprovedUser
    if self.status == 'approved'
      if !User.current_user.nil?
        self.update_column(:user_id, User.current_user.id) # This will skip validation gracefully.
      end
    end
  end

  def relatedPosts 
    tag_ids = self.tag_ids
    Post.joins(:tags).where(tags: {id: tag_ids}).where.not(posts: {id: self.id}).uniq[0..2]
  end

end
