package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class KlingonText extends MovieClip{
		
		private var foo:Array = ["s", "l", "f", "w", "k"];
		private var prepositionSize:uint = 3;
		private var prepositionsArray:Array;
		private var verbsArray:Array;
		private var verbsFirstPersonArray:Array;
		private var verbSize:uint = 8;
						
		public function KlingonText() {
			// constructor code			
			prepositionsArray = new Array();	
			verbsArray = new Array();	
			verbsFirstPersonArray = new Array();
			var url:String = "https://raw.githubusercontent.com/financas360/provas/master/klingon-textoB.txt";
            
			var loader:URLLoader = new URLLoader(new URLRequest(url));
			loader.addEventListener(Event.COMPLETE, onFileLoaded);
		}
		
		private function onFileLoaded(e:Event):void
		{
			var loader:URLLoader = e.target as URLLoader;
			var text:String = loader.data; //variável text recebe o texto do arquivo		
			
			createArrayOfWords(text);
		}

		private function createArrayOfWords(text:String):void{
			//Lê arquivo de texto. 
			//A cada 'espaço em branco' (via regEx) usa o 'espaco como separador' e cria um array de palavras.
			var wordsArray:Array = text.split(/\s/);	
			//Verifica se a string atende a um dos critérios e adiciona ao array correspondente.
			verifyWordType(wordsArray);			
		}	
		private function verifyWordType(listWords:Array):void{	
			trace("listWords.length = " + listWords.length);
			for(var i:uint = 0; i < listWords.length; i++){	
				isPreposition(listWords[i]);
				isVerb(listWords[i]);
			}
			trace(prepositionsArray);
			trace("numberPrepositions = " + prepositionsArray.length);
			trace(verbsArray);
			trace("numberVerbs = " + verbsArray.length);
			trace(verbsFirstPersonArray);
			trace("numberVerbsFirstPerson = " + verbsFirstPersonArray.length);
		}	
		
		private function isPreposition(word:String):void{
			if(word.length == prepositionSize) {
				if(word.indexOf('d') == -1){
					if(isFoo(word.charAt(word.length - 1)) == false){
						prepositionsArray.push(word);
					}
				}				
			}
		}
		
		private function isFoo(caracter:String):Boolean{
			var verifyFoo:Boolean = false;
			for(var i:uint = 0; i < foo.length; i++){
				if(caracter !=  foo[i]){
					continue;
				}else{
					verifyFoo = true;
					break;
				}
			}
			return verifyFoo;
		}
		
		private function isVerb(word:String):void{
			if(word.length >= verbSize) {				
				if(isFoo(word.charAt(word.length - 1)) == true){
					verbsArray.push(word);
					if(isFoo(word.charAt(0)) == false){
						verbsFirstPersonArray.push(word);
					}
				}				
			}
		}		
	}
	
}
