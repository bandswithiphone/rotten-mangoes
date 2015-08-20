class Movie < ActiveRecord::Base

      has_many :reviews

      mount_uploader :image, PosterimageUploader

      validates :title,
        presence: true

      validates :director,
        presence: true

      validates :runtime_in_minutes,
        numericality: { only_integer: true }

      validates :description,
        presence: true

      validates :release_date,
        presence: true

      validate :release_date_is_in_the_future

      def review_average
        reviews.sum(:rating_out_of_ten)/reviews.size if reviews.length > 0
      end

      def self.search(title,director,duration)
        if title 
          query = where('title LIKE ?', "%#{title}%")
        else
          query = self
        end
        if director 
          query = query.where('director LIKE ?',"%#{director}")
        end
        case duration
        when "1"
          query = query.where( :runtime_in_minutes => 0..89 )
        when "2"
          query = query.where( :runtime_in_minutes => 90..120 )
        when "3"
          query = query.where("runtime_in_minutes > ?",  120)
        end

          # if !duration.empty?
          #   duration = JSON.parse duration
          #   @min = duration[0]
          #     @max = duration[1]
          #   # find(:all,conditions: ['title LIKE ?', "%#{title}%"])
          #     where('title LIKE ?', "%#{title}%").where('director LIKE ?',"%#{director}").where('runtime_in_minutes > ? and 
          #       runtime_in_minutes <= ?',"#{@min}","#{@max}")
          # else
          #     where('title LIKE ?', "%#{title}%").where('director LIKE ?',"%#{director}") 
          # end
        query
      end


      protected

      def release_date_is_in_the_future
        if release_date.present?
          errors.add(:release_date, "should probably be in the future") if release_date < Date.today
        end
      end

    end