class DrawingService
    def self.perform(participants, attempt = 0)
      sorted_participants = participants.sort_by { |p| -p[:restricted_ids].size }
      assignments = []
      used_receivers = []
  
      sorted_participants.each do |giver|
        possible_receivers = sorted_participants.select do |receiver|
          giver[:id] != receiver[:id] && 
            !giver[:restricted_ids].include?(receiver[:id]) && 
            !used_receivers.include?(receiver[:id]) 
        end
  
        if possible_receivers.empty?
          attempt += 1
          raise "Unable to resolve a valid drawing after #{attempt} attempts." if attempt > 10
          return perform(participants, attempt)
        end
  
        selected_receiver = possible_receivers.sample
        assignments << { giver_id: giver[:id], receiver_id: selected_receiver[:id] }
        used_receivers << selected_receiver[:id]
      end
  
      assignments
    end
  end
  