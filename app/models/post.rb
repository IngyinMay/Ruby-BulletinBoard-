class Post < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true, length: { minimum: 10 }
    validates_inclusion_of :public_flag, :in => [true, false]

    def self.to_csv
        headers = Constants::POST_CSV_HEADER
        CSV.generate(headers: true) do |csv|
          csv << headers
          all.each do |post|
            csv << headers.map{ |attr| post.send(attr) }
          end
        end
    end

    def self.import(file,current_user_id)
        CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8', row_sep: :auto, header_converters: :symbol) do |row|
            Post.upsert(row.to_hash.merge(created_by: current_user_id, updated_by: current_user_id, created_at: Time.now, updated_at: Time.now))
        end
    end
end