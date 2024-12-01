#!/bin/bash

# контекст, директория хранения данных о курсах валют
contextPath="$HOME/.config/waybar/scripts/crypto-currency"

# файл json со всеми валютами, получаемыми из cbr
currencyJsonPath="${contextPath}/crypto-currency-cbr.json"

# обновление файла с json валют
function updateCurrencyCbr {
    curl https://api.cryptorank.io/v1/currencies?api_key=7396a09f92c95d9c830dd668b257153db107a355d71b201cb3cb569c3045 > $currencyJsonPath
}

# получение значения переданной валюты
# из JSON файла cbr
# округленного до 2-х знаков после запятой
function getRoundedCurrency {
	ethvalue=`cat ${currencyJsonPath} | jq -r '.data[1]|"\(.values.USD.price)"'`
    etharrow=`cat ${currencyJsonPath} | jq -r '.data[1]|"\(.values.USD.percentChange24h)"'`

	roundValue=`echo "scale=2;($ethvalue)/1" | bc`

	#echo $roundValue

    # получение стрелки вниз (падение валюты)
    # или вверх (рост валюты)
    function getCurrencyArrow {
	    local currencyKey="$1"

	    # если курс не поменялся
    	if [[ `echo "$currencyKey==0" | bc` -eq 1 ]]; then
		    echo ""
	    # курс изменился в большую сторону
	    elif [[ `echo "$currencyKey>0" | bc` -eq 1  ]]; then
		    echo "↑"
	    # курс изменился в меньшую сторону
	    else
		    echo "↓"
	    fi
    }
    result="$roundValue`getCurrencyArrow $etharrow`"
    echo $result
}



# сохранение значения переданной валюты
# и индикатора динамики изменения (стрелки) в отдельный файл
function saveCurrency {
    local currencyKey="$1"

	echo `getRoundedCurrency` > "$contextPath/crypto-eth"
}

### start ###

# создание директории, если не создана
mkdir -p "${contextPath}"

# обновление валют cbr
updateCurrencyCbr

# сохранение интересующих валют
saveCurrency 
