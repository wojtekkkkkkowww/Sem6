declare -A stats

#do zmiennej zapisuję listę plików, które potem będę chciał wyświetlać i przeszukiwać
FILES="$(svn ls -r $1 $2 --depth=infinity | grep '[^\/]$' | awk -v a="$1" -v b="$2" '{print b$0"@"a}' )"

#iteruję w pętli po plikach i wewnątrz pilku po słowach (dzięki temu jeden plik jest zaciągany tylko raz!)
for FILE in `echo "$FILES"`
do
	for WORD in `echo "$FILE" | xargs svn cat`
	do
		if [ stats[$WORD] ]; then
			((stats[$WORD]++))
		else
			stats[$WORD]=1
		fi
	done
done

for WORD in `echo "${!stats[@]}" | tr " " "\n" | sort`; #wyświetlamy tablicę z liczbą wystąpień w sposób posorotowany leksykograficznie
do
	echo "$WORD | ${stats[$WORD]}"
done
