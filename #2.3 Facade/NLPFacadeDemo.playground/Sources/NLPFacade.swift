import Foundation
import NaturalLanguage

public class NLPFacade {
    
    private static let tagger = NLTagger(tagSchemes: [.lexicalClass])
    
    public class func dominantLanguage(for string: String) -> String? {
        let language = NLLanguageRecognizer.dominantLanguage(for: string)
        return language?.rawValue
    }
    
    public struct WordLexicalClassPair: CustomStringConvertible {
        let word: String
        let lexicalClass: String
        
        public var description: String {
            return "\"\(word)\": \(lexicalClass)"
        }
    }
    
    public class func patsOfSpeech(for text: String) -> [WordLexicalClassPair] {
        var result = [WordLexicalClassPair]()
        tagger.string = text
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lexicalClass, options: [.omitPunctuation,   .omitPunctuation]) { tag, range -> Bool in
            let wordLexicalClass = WordLexicalClassPair(word: String(text[range]), lexicalClass: (tag?.rawValue ?? "unknown"))
            result.append(wordLexicalClass)
            
            return true
        }
        
        return result
    }
    
}
