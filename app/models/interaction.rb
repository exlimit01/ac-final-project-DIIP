class Interaction < ApplicationRecord

  belongs_to :friendship
  belongs_to :mission

  belongs_to :room

  # enum co_status: [
      #refresh: -1,
      #all_none: 0,
      #other_accept: 1,
      #accept_and_wait: 2,
      #other_reject: 3,
      #reject_other: 4,
      #start: 5,
      #me_done: 6,
      #other_done: 7,
      #all_done: 8
  # ]


  def request?
    self.status == "request"
  end

  def accept?
    self.status == "accept"
  end

  def none?
    self.status == "none"
  end

  def reject?
    self.status == "reject"
  end

  # 雙方都未開始
  def v2_all_none?
    #self.co_status == "none" && other_interaction.co_status == "none"
    self.co_status == 0
  end

  # 自己未開始 對方按確定
  def v2_other_accept?
    #self.co_status == "none" && other_interaction.co_status == "accept"
    self.co_status == 1
  end

  # 自己接受 等待對方同意
  def v2_accept_and_wait?
    #self.co_status == "accept" && other_interaction.co_status == "none"
    self.co_status == 2
  end

  # 對方拒絕 自己狀態不重要
  def v2_other_reject?
    #other_interaction.co_status == "reject"
    self.co_status == 3
  end

  # 自己拒絕別人 別人的狀態不重要
  def v2_reject_other?
    #self.co_status == "reject"
    self.co_status == 4
  end

  # 雙方同意 任務開始
  def v2_start?
    #self.co_status == "accept" && other_interaction.co_status == "accept"
    self.co_status == 5
  end

  # 自己完成任務 等待對方
  def v2_me_done?
    #self.co_status == "done" && other_interaction.co_status == "accept"
    self.co_status == 6
  end

  # 對方完成 等待自己
  def v2_other_done?
    #self.co_status == "accept" && other_interaction.co_status == "done"
    self.co_status == 7
  end

   # 雙方完成任務 任務結束
  def v2_all_done?
    #self.co_status == "done" && other_interaction.co_status == "done"
    self.co_status == 8
  end

end
