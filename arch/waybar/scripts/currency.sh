#!/bin/bash

# контекст, директория хранения данных о курсах валют
contextPath="$HOME/.config/waybar/scripts/currency"

# файл json со всеми валютами, получаемыми из cbr
currencyJsonPath="${contextPath}/currency-cbr.json"

# обновление файла с json валют
function updateCurrencyCbr {
    curl https://www.cbr-xml-daily.ru/daily_json.js > $currencyJsonPath
}

# получение значения переданной валюты
# из JSON файла cbr
# округленного до 2-х знаков после запятой
function getRoundedCurrency {
	local currencyKey="$1"

	value=`cat ${currencyJsonPath} | jq .Valute.$currencyKey.Value`
	roundValue=`echo "scale=2;($value)/1" | bc`

	echo $roundValue
}

# получение стрелки вниз (падение валюты)
# или вверх (рост валюты)
function getCurrencyArrow {
	local currencyKey="$1"

	value=`cat ${currencyJsonPath} | jq .Valute.$currencyKey.Value`
	valuePrevious=`cat ${currencyJsonPath} | jq .Valute.$currencyKey.Previous`

	# если курс не поменялся
	if [[ `echo "$value==$valuePrevious" | bc` -eq 1 ]]; then
		echo ""
	# курс изменился в большую сторону
	elif [[ `echo "$value>$valuePrevious" | bc` -eq 1  ]]; then
		echo "↑"
	# курс изменился в меньшую сторону
	else
		echo "↓"
	fi
}

# сохранение значения переданной валюты
# и индикатора динамики изменения (стрелки) в отдельный файл
function saveCurrency {
	local currencyKey="$1"

	echo `getRoundedCurrency "$currencyKey"``getCurrencyArrow "$currencyKey"` > "$contextPath/$currencyKey"
}

### start ###

# создание директории, если не создана
mkdir -p "${contextPath}"

# обновление валют cbr
updateCurrencyCbr

# сохранение интересующих валют
saveCurrency "USD"
saveCurrency "EUR"
saveCurrency "CNY"
