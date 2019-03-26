package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class SortWord extends MovieClip{
		
		private var klingonAlphabet:Array = ["k", "b", "w", "r", "q", "d", "n", "f", "x", "j", "m", "l", "v", "h", "t", "c", "g", "z", "p", "s"];
		//variaveis para transfortmar de Klingon para o Real alfabeto e fazer o caminho inverso
		private var tempAlphabet:Array = ["a", "b", "0", "1", "e", "2", "3", "4", "i", "j", "5", "l", "6", "n", "o", "7", "8", "9", "*", "!"];
		private var auxAlphabet:Array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "!"];
		private var complementAlphabet:Array = ["c", "d", "f", "g", "h", "k", "m", "p", "q", "r", "s", "t"];
		
		
		
		private var realAlphabet:Array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t"];
				
		
		private var originalKlingonText:String;
		
		private var klingonToRealAlphabetText:String; 
		private var stringKlingonToRealOrdered:String;   
		private var realToKlingonAlphabetText:String;  
		
		
		private var wordsWithoutDuplicationArray:Array;
		private var wordOrderingArray:Array;
		
		
		
		public function SortWord() {
			// constructor code		
			
			wordsWithoutDuplicationArray = new Array();
			wordOrderingArray = new Array();
						
			var url:String = "https://raw.githubusercontent.com/financas360/provas/master/klingon-textoB.txt";
            
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, onFileLoaded);
		}
		
		private function onFileLoaded(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			var originalKlingonText:String = loader.data; //variável text recebe o texto do arquivo	
			
			
			trace('String original em Klingon:'); 
			trace(originalKlingonText);
			
			convertStringToRealAlphabet(originalKlingonText);
			
			//createArrayOfWords(originalKlingonText);
		}
		
		private function convertStringToRealAlphabet(str:String):void{
			
			for(var i:uint = 0; i < str.length; i++){					
				
				for(var j:uint = 0; j < klingonAlphabet.length; j++){	
					
					str = str.split(klingonAlphabet[j]).join(tempAlphabet[j]);
					//trace(str);										
				}				
			}
			
			trace("String Klingon transformada em alfanumérico:");
			trace(str);
			
			for(i = 0; i < str.length; i++){					
				
				for(j = 0; j < auxAlphabet.length; j++){	
					
					str = str.split(auxAlphabet[j]).join(complementAlphabet[j]);
					//trace(str);										
				}				
			}
			
			klingonToRealAlphabetText = str;
			trace("String Klingon transformada para o alfabeto Real:");
			trace(klingonToRealAlphabetText);
			
			createArrayOfWords(klingonToRealAlphabetText);
		}

		private function createArrayOfWords(text:String):void{
			//Lê arquivo de texto. 
			//A cada 'espaço em branco' (via regEx) usa o 'espaco como separador' e cria um array de palavras.
			var wordsArray:Array = text.split(/\s/);	
			///trace("initialNumberWords = " + wordsArray.length);
			//Elimina as palavras duplicadas
			removeDuplicateWords(wordsArray);
		}	
		
		private function removeDuplicateWords(listWords:Array):void{			
			
			//ordena array de palavras recebido
			listWords.sort();
			///trace(listWords);
			///trace(listWords[0]);
			var i:int = 0;
			while(i < listWords.length) {
				//enquanto 'i' for menor que o tamanho do 'array +1' e se a 'primeira palavra' for igual a 'segunda palavra' no array, remove a 'primeira palavra
				while(i < listWords.length+1 && listWords[i] == listWords[i+1]) {
					listWords.splice(i, 1);
				}
				i++;
			}
			wordsWithoutDuplicationArray = listWords;
			
			//remove item do array incluido somente com espaço em branco
			//wordsWithoutDuplicationArray.splice(wordsWithoutDuplicationArray.indexOf(/\s/), 1);
						
			//ordena de acordo com a ordem do alfabeto real.
			sortAlphabetOrder(wordsWithoutDuplicationArray);
		}	
		
		private function sortAlphabetOrder(listWords:Array):void{
			for(var i:uint = 0; i < realAlphabet.length; i++){
				for(var j:uint = 0; j < wordsWithoutDuplicationArray.length; j++){
					if(wordsWithoutDuplicationArray[j].charAt(0) == realAlphabet[i]){
						wordOrderingArray.push(wordsWithoutDuplicationArray[j]);
					}
				}
			}
			
			//cria string com as palavras ordenadas pelo primeiro caracter
			trace('String de palavras ordenadas pelo alfabeto Real, depois do Klingon ter sido transformado para o Real:'); 
			stringAtWords(wordOrderingArray);				
		}
		
		private function stringAtWords(array:Array):void{
			
			var sortedString:String = "";
			for(var i:uint = 0; i < array.length; i++) 
			{				
				sortedString += array[i];
				if(i != (array.length - 1))
					sortedString += " ";				
			}
			
			stringKlingonToRealOrdered = sortedString;
			trace(stringKlingonToRealOrdered);
			trace("\n");
			convertStringToKlingonAlphabet(stringKlingonToRealOrdered);
		}
		
		private function convertStringToKlingonAlphabet(str:String):void{
			
			for(var i:uint = 0; i < str.length; i++){					
				
				for(var j:uint = 0; j < complementAlphabet.length; j++){	
					
					str = str.split(complementAlphabet[j]).join(auxAlphabet[j]);
					//trace(str);										
				}				
			}
			
			trace("String Real transformada em alfanumérico:");
			trace(str);
			
			
			for(i = 0; i < str.length; i++){					
				
				for(j = 0; j < tempAlphabet.length; j++){	
					
					str = str.split(tempAlphabet[j]).join(klingonAlphabet[j]);
					//trace(str);										
				}				
			}
			
			realToKlingonAlphabetText = str;
			
			trace('String de palavras em Klingon ordenadas:'); 
			trace(realToKlingonAlphabetText);
			
		}
		
		/*
		private function convertStringToKlingonAlphabet(str:String):void{
			
			for(var i:uint = 0; i < str.length; i++){					
				
				for(var j:uint = 0; j < realAlphabet.length; j++){	
					
					str = str.split(realAlphabet[j]).join(tempKlingonAlphabet[j]);
					//trace(str);										
				}				
			}
			
			trace("String Real transformada em alfanumérico:");
			trace(str);
			
			for(i = 0; i < str.length; i++){					
				
				for(j = 0; j < auxAlphabet.length; j++){	
					
					str = str.split(auxAlphabet[j]).join(complementKlingonAlphabet[j]);
					//trace(str);										
				}				
			}
			
			realToKlingonAlphabetText = str;
			
			trace('String de palavras em Klingon ordenadas:'); 
			trace(realToKlingonAlphabetText);
			
			//createArrayOfWords(realToKlingonAlphabetText);
			
		}*/
		
		
		
		private function replace( str:String, search:String, replacement:String ):void {
			var a:int = search.length;
			var b:int = replacement.length;
			var o:int = 0;
			var i:int;
			while( ( i = str.indexOf( search, o ) ) != -1 ) {
				str = str.substr( 0, i ) + replacement + str.substr( i + a );
				o = i + b;
			}
			trace(str);
		}
		
		function setCharAt(str:String, char:String,index:int):String {
			return str.substr(0,index) + char + str.substr(index + 1);
		}
		
		//ordena em todos index pelo padrao Klingon
		private function sortedKlingonFull(str:String, pattern:String):void{
			trace('sortedKlingonFull');  
			
			
		}             
	}	
}
