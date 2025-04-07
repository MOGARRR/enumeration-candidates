# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program

def find(id)
  candidate = @candidates.select{|person| person[:id] == id}
    if candidate.length > 0
      return candidate[0]
    else
      return nil
    end
  end
  
  def experienced?(candidate)
  if candidate[:years_of_experience] >= 2
     return true
  else
    return false
  end
end
  
def qualified_candidates(candidates)
  have_experince = candidates.select{|candidate| experienced?(candidate)}
  have_github_points = have_experince.select{|candidate| github_points_requirement(candidate)}
  have_languages = have_github_points.select{|candidate| languages_requirement(candidate)}
  have_applied_recently = have_languages.select{|candidate| date_applied_requirement(candidate)}
  qualified_candidates_list = have_applied_recently.select{|candidate| age_requirement(candidate)}
  return qualified_candidates_list
 end
  
  # More methods will go below

  def github_points_requirement(candidate)
    if candidate[:github_points] >= 100
      return true
    else
      return false
    end
  end

  def languages_requirement(candidate)
    if candidate[:languages].include?('Ruby')
      return true
    elsif candidate[:languages].include?('Python')
      return true
    else 
      return false
    end
  end

  def date_applied_requirement(candidate)
    if candidate[:date_applied] >= 15.days.ago.to_date
      return true
    else 
      return false
    end
  end

  def age_requirement(candidate)
    if candidate[:age] >= 18
      return true
    else
      return false
    end
  end

  def ordered_by_qualifications(candidates)
    sorted_candidates = candidates.sort {|candidate_1, candidate_2| [candidate_1[:years_of_experience], candidate_1[:github_points]] <=> [candidate_2[:years_of_experience], candidate_2[:github_points]]}.reverse
    return sorted_candidates
  end

