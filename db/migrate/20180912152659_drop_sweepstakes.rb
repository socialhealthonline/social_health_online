class DropSweepstakes < ActiveRecord::Migration[5.2]
  def change
    drop_table :sweepstakes
  end
end
