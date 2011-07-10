require 'mongomatic'
 
class MUser < Mongomatic::Base
  BLANK_PHOTO_URL = "blank_profile_photo.png"

  def self.create_from_hash!(hash)
    muser = MUser.new()
    muser['name'] = hash['user_info']['name']
    muser['image_url'] = hash['user_info']['image']
    muser['categories'] = ["Groceries", "Health", "Eating Out", "Car"]
    muser.insert
    muser
  end

  def self.find_by_id(id)
    MUser.find_one({'_id' => id})
  end

  def id
    self["_id"].to_s
  end

  def name
    self["name"]
  end

  def nickname
    self["nickname"]
  end

  def photo_url
    if self["show_linked_in_photo"] and not self["image_url"].blank?
      return self["image_url"]
    else
      return BLANK_PHOTO_URL
    end
  end

end
