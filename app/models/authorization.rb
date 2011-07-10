require 'mongomatic'
require 'muser'

class Authorization < Mongomatic::Base

  def self.find_from_hash(hash)
    find_one({  "provider" => hash["provider"],
                "uid" => hash["uid"]
              })
  end

  def self.create_from_hash(hash, user = nil)
    user = MUser.create_from_hash!(hash)
    a = Authorization.new()
    a["user_id"] = user["_id"]
    a["uid"] = hash['uid']
    a["provider"] = hash['provider']
    a.insert
    a
  end

  def user
    @user ||= MUser.find_by_id(self["user_id"])
  end
end
