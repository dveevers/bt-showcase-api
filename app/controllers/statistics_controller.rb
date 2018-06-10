class StatisticsController < ApplicationController
  def keywords

    @stats = Message.all.group(:keyword)
    #missing order will be nil -> same as false
    if 'asc'.casecmp?(params['order'])
      @stats = @stats.order('count_id ASC') 
    elsif 'alpha'.casecmp?(params['order'])
      @stats = @stats.order('keyword ASC')   
    else
      @stats = @stats.order('count_id DESC')
    end    

  	json_response(@stats.count('id'))
  end

  def channels

    @stats = Message.all.group(:channel)
    #missing order will be nil -> same as false
    if 'asc'.casecmp?(params['order'])
      @stats = @stats.order('count_id ASC') 
    elsif 'alpha'.casecmp?(params['order'])
      @stats = @stats.order('keyword ASC')   
    else
      @stats = @stats.order('count_id DESC')
    end    

    json_response(@stats.count('id'))
  end

end
