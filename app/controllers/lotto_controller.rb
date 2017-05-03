require ('open-uri')
require ('json')

class LottoController < ApplicationController
def index # index 액션에는 아무런 로직도 담겨있지 않다.
end

def pick_and_check
get_info = JSON.parse open('http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=').read

drw_numbers = []
get_info.each do |k, v|
drw_numbers << v if k.include? 'drwtNo'
end
drw_numbers.sort!

bonus_number = get_info["bnusNo"]
my_numbers = [*1..45].sample(6).sort
match_numbers = drw_numbers & my_numbers
match_cnt = match_numbers.count

if match_cnt == 6
result = '1등'
elsif match_cnt == 5 && my_numbers.include?(bonus_number)
result = '2등'
elsif match_cnt == 5
result = '3등'
elsif match_cnt == 4
result = '4등'
elsif match_cnt == 3
result = '5등'
else
result = '꽝'
end

# 이름은 같을 필요 없지만 편의를 위해 같게 설정.
@my_numbers = my_numbers
@drw_numbers = drw_numbers
@bonus_number = bonus_number
@match_numbers = match_numbers
@result = result
end
end
