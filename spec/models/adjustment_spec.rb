require 'rails_helper'

RSpec.describe Adjustment, type: :model do
  describe 'ordering' do
    it 'adds new adjustments to the bottom' do
      user = create(:user)

      agenda_item1 = create(:agenda_item, status: :current)
      agenda_item2 = create(:agenda_item)
      agenda_item3 = create(:agenda_item)

      adjustment1 = create(:adjustment, user: user, agenda_item: agenda_item1)
      adjustment2 = create(:adjustment, user: user, agenda_item: agenda_item2)
      adjustment3 = create(:adjustment, user: user, agenda_item: agenda_item3)

      user.adjustments.rank(:row_order).should eq [adjustment1, adjustment2, adjustment3]
    end

    it 'moves the last adjustment to the top' do
      user = create(:user)

      agenda_item1 = create(:agenda_item, status: :current)
      agenda_item2 = create(:agenda_item)
      agenda_item3 = create(:agenda_item)

      adjustment1 = create(:adjustment, user: user, agenda_item: agenda_item1)
      adjustment2 = create(:adjustment, user: user, agenda_item: agenda_item2)
      adjustment3 = create(:adjustment, user: user, agenda_item: agenda_item3)

      adjustment3.update(row_order_position: 0)

      user.adjustments.rank(:row_order).should eq [adjustment3, adjustment1, adjustment2]
    end

    it 'deltes an adjustment' do
      user = create(:user)

      agenda_item1 = create(:agenda_item, status: :current)
      agenda_item2 = create(:agenda_item)
      agenda_item3 = create(:agenda_item)

      adjustment1 = create(:adjustment, user: user, agenda_item: agenda_item1)
      adjustment2 = create(:adjustment, user: user, agenda_item: agenda_item2)
      adjustment3 = create(:adjustment, user: user, agenda_item: agenda_item3)

      adjustment2.destroy

      user.adjustments.rank(:row_order).should eq [adjustment1, adjustment3]
    end

    it 'moves up an adjustment' do
      user = create(:user)

      agenda_item = create(:agenda_item, status: :current)

      a1 = create(:adjustment, user: user, agenda_item: agenda_item)
      a2 = create(:adjustment, user: user, agenda_item: agenda_item)
      a3 = create(:adjustment, user: user, agenda_item: agenda_item)
      a4 = create(:adjustment, user: user, agenda_item: agenda_item)
      a5 = create(:adjustment, user: user, agenda_item: agenda_item)

      a4.update(row_order_position: 1)

      user.adjustments.rank(:row_order).should eq [a1, a4, a2, a3, a5]
    end
  end
end
