ScriptName aaMp_SatietySystemPlayerController extends Actor  

; ======== Properties ========
Faction property satietyFaction Auto

; ======== Variables ========

float satietyValue = 110.0
float tempSatietyValue

;/
	������, ������� ������ � ���� �������� �������� ��������� �������� ������� � ������ �������.
	[0]	-	�������� �������� ��������� ����� X
	[1]	-	�������� �������� ��������� ����� ��� ����� X
	[2]	-	id ������ �������
/;
float[] satietyValuesArray

; ======== Event ========

event OnInit()
	RegisterForSingleUpdate(aaMP_SatietySystemSatietyService.satietyUpdateTimeUnit())
	satietyValuesArray = new float[3]
	satietyValuesArray[0] = 100.0
	satietyValuesArray[1] = 120.0
	satietyValuesArray[2] = 6.0
	AddToFaction(satietyFaction)
endEvent

;/
	�����, �������� ��� ���������� ��������� ������� �������� ������� � �������� �������� ������ �������.
/;
event onUpdate()
	if (!IsEnabled())
		return
	endIf
	
	removeSatietyPoint(aaMP_SatietySystemSatietyService.satietyPointRemovePerTimeUnit())
	checkAndHandleSturveDeath()
	updateCurrentSatietyStage()
	Debug.Notification("�������: " + satietyValue)
	RegisterForSingleUpdate(aaMP_SatietySystemSatietyService.satietyUpdateTimeUnit())
endEvent


; ======== Functions ========

;/
	������� �������� ���������� ����� �� �������� ��������� �������, ���� ��� ��������.
	inputSatietyValue	-	���������� ����� �������.

	!���������� ��������� ������ 0.
/;
function removeSatietyPoint(float inputSatietyValue)
	tempSatietyValue = satietyValue - inputSatietyValue
	if (tempSatietyValue < 0.0)
		satietyValue = 0
	else
		satietyValue = tempSatietyValue
	endIf
endFunction


;/
	������� ���������, ����� �� ������� ������ 0.
	���� �� - ������� ������ � ����������� ��� ������� �� 50 (�������, ������� ����������).
/;
function checkAndHandleSturveDeath()
	if (satietyValue == 0.0)
		Kill()
		satietyValue = 50.0
	endIf
endFunction


;/
	������� ��������� ���������� ����� � �������� ��������� ������� � ������ ������������� ������������ �������, ���� ��� ��������.
	inputSatietyValue	-	������������ ����� �������.

	!���������� ��������� ������ 120.
/;
function addSatietyPoint(float inputSatietyValue)
	tempSatietyValue = satietyValue + inputSatietyValue * getCalculateSatietyModificator()
	if (tempSatietyValue > 120.0)
		satietyValue = 120.0
	else 
		satietyValue = tempSatietyValue
	endIf
endFunction


;/
	������� ��������������������� ����������� ������������� ���������.
/;
float function getCalculateSatietyModificator()
	if(satietyValue >= aaMP_SatietySystemSatietyService.satietyModificatorLimitValue())
		return 1.0
	else
		return (1.0 + ((aaMP_SatietySystemSatietyService.satietyModificatorLimitValue() - satietyValue) * aaMP_SatietySystemSatietyService.satietyModificatorPerValue()))
	endif
		
endFunction


;/
	������� ���������, ��������� �� ������� ������� � ������ �������� ���������. 
	��� ��������� ��������� ���������������� ����� ������ ������, 
	� �� ��������� ����� ������ �������� ���� �� ������� ������.
/;
function updateCurrentSatietyStage()
	if (!aaMP_Utility.comparePointInInterval(satietyValue, satietyValuesArray[0], satietyValuesArray[1]))
		aaMP_SatietySystemSatietyService.findActualSatietyStage(satietyValue, satietyValuesArray)
		SetFactionRank(satietyFaction, (satietyValuesArray[2] as int))
	endIf
endFunction

