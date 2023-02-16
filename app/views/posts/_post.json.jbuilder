json.extract! post, :id, :category_id, :subject_ar, :subject_en, :description_ar, :description_en, :reference, :timestamp, :date, :flag, :status, :views, :created_at, :updated_at
json.url post_url(post, format: :json)
