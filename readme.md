# 설명

Autohotkey를 이용해서, {Lshift}+{space}으로 한영 입력 간에 전환할 때, 날개셋입력기의 초기상태를 한글입력상태로 바꿈.

### 사용환경과 목표

- MS Windows 10 x64 Eng
- 윈도우의 기본 영문입력기
- 날개셋입력기 (http://moogi.new21.org/prg4.html)



# 특징

1. (의도) {Lshift}+{space}를 누르면 텍스트 입력 커서 위치에 KO 혹은 EN을 잠깐동안 표시함.



#  주의사항과 문제점

1. 시스템 트레이 아이콘을 표시하지 않음.
2. autohotkey의 A_CaretX와 A_CaretY에 대해, 많은 수의 응용프로그램들이 정확한 위치를 보고하지 않기 때문에, IMETooltip이 표시되는 위치가 정확하지 않은 경우가 많고, 마우스 커서를 따라가기도 함.
3. {space}가 비정상적으로 전송됨.



# 사용법

1. 영문입력기와 한글입력기간의 변환을 {ctrl}+{shift}로 바꾼다.

   > 1. 윈도우키를 누르고 advanced keyboard settings를 입력한다.
   >    (또는 시작버튼/ settings/ Devices/ Typing/ Advanced keyboard settings를 선택한다.)
   >
   > 2. Input lauguage hot keys 를 선택한다.
   >
   > 3. Advanced Key Settings 탭/ Hot Keys for input languages/ Between input languages 를 ctrl+shift로 바꾼다.

2. 내려받은 IMEtooltipKorEng.exe를 실행한다.

3. {Lshift}+{space}를 눌러 입력기를 변경한다.



# 동기

- 필자가 영문 윈도우10 x64에서 드보락 키보드들 사용하고, 한글을 입력하기 위해 날개셋 입력기를 통해서 필자 본인만의 신세벌식 배열을 사용한다.

- 날개셋 입력기를 사용할 때 불편한 점이 있다. 
  영문입력기상태에서 날개셋입력기상태로 넘어가면 빈입력스키마가 기본으로 지정되고 다시 한글 입력을 위해서 {Lshift}+{space}를 입력해야 한다는 점이다. 
  즉 {Lalt}+{shift}를 입력해 날개셋입력기를 선택하고 다시 {Lshift}+{space}를 입력해 한글입력상태로 바꾼다. 
  이는 날개셋입력기의 문제가 아니라 윈도우10 시스템의 IME의 기본적인 작동방식으로부터 기인한다.
- {Lshift}+{space}만으로 한글입력상태와 영문입력상태 사이를 오갈 수 있도록 만든다.



### {shift}+{space}를 선택한 이유

필자가 우분투 20.04 와 리눅스민트 20.1에서 uim과 uim-byeoru를 수정해서 본인만의 신세벌식 배열을 사용하는데, uim의 입력 언어 변경 단축키가 {Lshift}+{space}이기도 하고,
이 단축키를 아주 오래전부터 한글 입력 상태로 가기 위해서 사용하기도 했다.
또한, 영문 Dvorak 상태에서 {한/영} 키와 {한자} 키가 작동하지 않는 경우가 많다.



# References

깃허브 사용법에 아직 익숙하지 않아서 이렇게 기록으로 남긴다.

### 깃허브(source code)

https://github.com/selfiens/KorTooltip
(깃허브 사용법을 숙지하면, 여기로부터 fork 하여 branch 를 만들 예정임.)



### 외부

http://www.autohotkey.co.kr/cgi/board.php?bo_table=qna&wr_id=20839

https://iamaman.tistory.com/1805



### 날개셋입력기 제작자인 김용묵이 윈도우 IME에 대해서 설명함

https://cosmic.mearie.org/f/ngsdoc/ngsm_ntc_ischeme.htm

