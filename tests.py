import re
import pymongo

# Connect to the MongoDB server
client = pymongo.MongoClient("mongodb://hpcsmdb.uplinkautomation.com:27017/")
db = client["books"]
collection_name = "book1"  # Collection name for the book

text = "Mind; afternoon; agg.; five pm.: calc calc chin-s CON(3) hyper lac-h nux-v ol-an paeon plb sil sol-t-ae SULPH(3) thea thuj."

# Check if ':' exists in the text
if ':' in text:
    chapter_match = re.match(r'^(.*?);', text)
    symptom_match = re.search(r';(.*?):', text)
    cures_match = re.search(r':\s*(.*)$', text)
    
    if chapter_match and symptom_match and cures_match:
        chapter_name = chapter_match.group(1).strip()
        symptom_text = symptom_match.group(1).strip()
        cures_text = cures_match.group(1).strip()
        
        print("Chapter:", chapter_name)
        print("Symptom Text:", symptom_text)
        
        cures_dict = {}
        cures_list = cures_text.split()
        
        for cure in cures_list:
            match = re.match(r'([A-Za-z-]+)(\(\d+\))?', cure)
            if match:
                cure_name = match.group(1)
                cure_intensity = match.group(2)
                if cure_intensity:
                    cure_intensity = int(cure_intensity.strip('()'))
                else:
                    cure_intensity = 1
                cures_dict[cure_name] = {
                    'power': cure_intensity,
                    'syp': -1,
                    'syc': -1,
                    'pso': -1,
                    'tb': -1,
                    'ph': -1
                }
        
        # Insert into MongoDB
        chapter_doc = {
            "chapter_name": chapter_name,
            symptom_text: {
                "symptom_id": -1,  # Ask the user for this value
                "cures": cures_dict
            }
        }

        # Insert only if the symptom text is not already present
        existing_symptom = db[collection_name].find_one({chapter_name: {symptom_text: {"$exists": True}}})
        if not existing_symptom:
            db[collection_name].insert_one(chapter_doc)
            print("Data inserted into MongoDB.")
        else:
            print("Symptom text already exists in the collection.")

    else:
        print("Failed to extract information.")
else:
    chapter_match = re.match(r'^(.*?);', text)
    symptom_match = re.search(r';(.*?)$', text)
    
    if chapter_match and symptom_match:
        chapter_name = chapter_match.group(1).strip()
        symptom_text = symptom_match.group(1).strip()
        
        print("Chapter:", chapter_name)
        print("Symptom Text:", symptom_text)
    else:
        print("Failed to extract information.")
