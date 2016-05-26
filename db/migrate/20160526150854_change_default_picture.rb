class ChangeDefaultPicture < ActiveRecord::Migration
  def change
    change_column_default(:users, :picture, 'http://www.sessionlogs.com/media/icons/defaultIcon.png')
  end
end
