Scriptname aaMP_SatietySystemSatietyService

;/
	������, ���������� ��������������� �������  � ���������������� ���������� �������� ������������ � ������� ������ ������.
/;


; ======== Config Variable ========


;/
	���������� �������� ����� �������, ������� ����� ����������� �� ������� �������.
/;
float function satietyPointRemovePerTimeUnit() global
	return 6.0
endFunction


;/
	���������� �������� �������, ��� � ������� ����� ����������� ���������� ������� ������ � ��������� �������.
/;
float function satietyUpdateTimeUnit() global
	return 5.0
endFunction


;/
	���������� ����������� �������������, ��������� �� �������� �������� �������
	��� �������� 0.05 ��� ������ ������������ 80.0 ������� #getAddSatietyModificator(...) ������ 1.0,
	��� ������� ������ 20.0 ������� ������ #getAddSatietyModificator(...) 4.0.
/;
float function satietyModificatorPerValue() global
	return 0.05
endFunction


;/
	���������� ����� �������, ���� �������� ����������� ������������� ������� �� �����������.
/;
float function satietyModificatorLimitValue() global
	return 80.0
endFunction


; ======== Functions ========

;/
	������� ���������� �������� ������ ������� ������ �� ��������� ����� �������,
	� ��������� ���������� ������ ���������� ������ ��������� ������� � ����� �������.
	�������� �� ������ ����������� ������ �� ��������� �����.
	satietyValue		-	�������� ������� ������.
	satietyStageValues	-	������, � �������:
	[0]					-	�������� �������� ��������� ����� X
	[1]					-	�������� �������� ��������� ����� ��� ����� X
	[2]					-	id ������ �������
/;
function findActualSatietyStage(float satietyValue, float[] satietyStageValues) global
	if (aaMP_Utility.comparePointInInterval(satietyValue, -100.0, 60.0))
		if (aaMP_Utility.comparePointInInterval(satietyValue, -100.0, 20.0))
			if (aaMP_Utility.comparePointInInterval(satietyValue, -100.0, 0.0))
				satietyStageValues[0] = -100.0
				satietyStageValues[1] = 0.0
				satietyStageValues[2] = 0.0
			else
				satietyStageValues[0] = 0.0
				satietyStageValues[1] = 20.0
				satietyStageValues[2] = 1.0
			endIf
		else
			if (aaMP_Utility.comparePointInInterval(satietyValue, 20.0, 40.0))
				satietyStageValues[0] = 20.0
				satietyStageValues[1] = 40.0
				satietyStageValues[2] = 2.0
			else
				satietyStageValues[0] = 40.0
				satietyStageValues[1] = 60.0
				satietyStageValues[2] = 3.0
			endIf
		endIf
	else
		if (aaMP_Utility.comparePointInInterval(satietyValue, 60.0, 100.0))
			if (aaMP_Utility.comparePointInInterval(satietyValue, 60.0, 80.0))
				satietyStageValues[0] = 60.0
				satietyStageValues[1] = 80.0
				satietyStageValues[2] = 4.0
			else
				satietyStageValues[0] = 80.0
				satietyStageValues[1] = 100.0
				satietyStageValues[2] = 5.0
			endIf
		else
			if (aaMP_Utility.comparePointInInterval(satietyValue, 100.0, 120.0))
				satietyStageValues[0] = 100.0
				satietyStageValues[1] = 120.0
				satietyStageValues[2] = 6.0
			else
				satietyStageValues[0] = 120.0
				satietyStageValues[1] = 200.0
				satietyStageValues[2] = 7.0
			endIf
		endIf
	endIf
endFunction