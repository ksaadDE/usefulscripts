Luckily enough, nobody needs to install the entire scispacy library to just obtain the Abbreviation Extraction utility :)  https://github.com/allenai/scispacy/blob/main/scispacy/abbreviation.py

Just in case someone needs it as well.  To include and use it:

```python3
from filename import AbbreviationDetector
loaded_nlp_model.add_pipe('abbreviation_detector')
```

Example code, partially ~~stolen~~ borrowed from [StackOverflow](https://stackoverflow.com/a/57558882)
```python
import spacy
from filename import AbbreviationDetector

def filter_abbrv (loaded_nlp_model, txtData):
        loaded_nlp_model.add_pipe('abbreviation_detector')
        doc=loaded_nlp_model (txtData)
        altered_tok=[tok.text for tok in doc]
        print("abbrv:", doc._.abbreviations)
        for abrv in doc._.abbreviations:
            altered_tok[abrv.start]=str(abrv._.long_form)
        return (" ".join(altered_tok))

loaded_nlp_model = spacy.load("en_core_web_lg") # or whatever
filter_abbrv (loaded_nlp_model, "StackOverflow (SO) and Github are pretty cool")
```
