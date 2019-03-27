package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;	
	
	public class KlingonNumbers extends MovieClip{		
			
		private var klingonAlphabet:Array = ["k", "b", "w", "r", "q", "d", "n", "f", "x", "j", "m", "l", "v", "h", "t", "c", "g", "z", "p", "s"];
								
		private var originalKlingonText:String;
		
		private var wordsWithoutDuplicationArray:Array;
		
		private var valuesArray:Array;
		private var numerosBonitosDistintosArray:Array;
		
		
		public function KlingonNumbers() {
			// constructor code						
			var url:String = "https://raw.githubusercontent.com/financas360/provas/master/klingon-textoB.txt";
            
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, onFileLoaded);
		}
		
		private function onFileLoaded(e:Event):void
		{
			wordsWithoutDuplicationArray = new Array();
			valuesArray = new Array();
			numerosBonitosDistintosArray = new Array();
			
			var loader:URLLoader = e.target as URLLoader;
			var text:String = loader.data; //variável text recebe o texto do arquivo		
			originalKlingonText = text;
			
			trace("Texto original em Klingon");
			trace(originalKlingonText);
			
			//cria array de palavras
			createArrayOfWords(originalKlingonText);
		}
		
		private function createArrayOfWords(text:String):void{
			//Lê arquivo de texto. 
			//A cada 'espaço em branco' usa o 'espaco como separador' e cria um array de palavras.
			var wordsArray:Array = text.split(" ");	
			trace("Array de Palavras:");
			trace(wordsArray.length);
			trace(wordsArray);
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
			
			trace("Array sem palavras duplicadas:");
			trace(wordsWithoutDuplicationArray);
			trace(wordsWithoutDuplicationArray.length);
			
			//calcula o valor de cada string dentro do array para um número na base 20
			//de acordo com as regras Klingon
			arrayToNumberBase20(wordsWithoutDuplicationArray);	
		}	
		
		private function arrayToNumberBase20(array:Array):void{
			trace("arrayToNumberBase20:");			    
			trace("array.length: " + array.length); 
			
			var str:String;			
			
			//tamanho do array
			for(var i:uint = 0; i < array.length; i++) 
			{
				
				var stringValue:Number = 0;
				
				str = array[i].toString();
				trace("str[" + i + "]: " + str);
				//tamanho da string dada a posicao do array
				trace("str[" + i + "].length: " + array[i].length);
				
				//varre os caracteres da string
				for(var j:uint = 0; j < str.length; j++)
				{							
					//tamanho do alfabeto Klingon
					for(var k:uint = 0; k < klingonAlphabet.length; k++)
					{
						//trace("klingonAlphabet.length: " + klingonAlphabet.length);
						if(str.charAt(j) == klingonAlphabet[k])
						{								
							//trace("str.charAt("+ j + "): " + str.charAt(j));							
							var value:Number = Math.pow(20,j) * k;
							//trace("Valor do caracter na posicao [" + j + "]: " + value);
						}							
					}			
					
					stringValue = stringValue + value;
				}					
				trace("stringValue(" + i + "): " + stringValue);
				valuesArray.push(stringValue);
				//verifica se é um número bonito distinto
				if((stringValue >= 440556) && ((stringValue % 3) == 0)){
					numerosBonitosDistintosArray.push(stringValue);					
				}
			}	
			
			trace("Quantidade de números bonitos no texto: " + numerosBonitosDistintosArray.length);		
		}	
	}
}
