export function getCookedObjForSending(cooked) {
  const obj = {};

  Object.assign(obj, cooked);
  obj.kcal_1 = cooked.nutrValues1[0];
  obj.proteins_1 = cooked.nutrValues1[1];
  obj.fats_1 = cooked.nutrValues1[2];
  obj.carbohydrates_1 = cooked.nutrValues1[3];
  delete obj.id;
  delete obj.nutrValues1;
  
  return obj;
}
//cooked id is added on backend during transaction;
export function getIngrsForSending(ingridients) {
  const arr = [];
  for(let ingridient of ingridients) {
    if(ingridient.id && ingridient.id !== null && ingridient.weight > 0) {
      arr.push({
        ingrId: ingridient.id,
        ingrWeight: ingridient.weight 
      });
    }
  }
  return arr;
}

export function getCookedForList(cooked, forUpdate = false) {
  const obj = {};
  const nutrValues = nutrValues100(cooked.nutrValues1);
  obj.name = cooked.name;
  obj.weight = cooked.weight;  
  obj.kcal = nutrValues[0];
  obj.proteins = nutrValues[1];
  obj.fats = nutrValues[2];
  obj.carbohydrates = nutrValues[3];
  if(!forUpdate) {
    obj.id = cooked.id;
    obj.date = cooked.date;
  }
  return obj;
}

export function nutrValues100(nutrValues1) {
  return nutrValues1.map(item => +(item * 100).toFixed(2));
}

export function getIngrsForList(ingridients) {
  const ingrsArr = getIngrsArrFromSet(ingridients);

  for(let ingridient of ingrsArr) {
    Object.assign(ingridient, ingridient.nutrValues1);
    delete ingridient.listId;
    delete ingridient.nutrValues1;
    delete ingridient.nutrValuesW;
  }
  return ingrsArr;
}

export function getIngrsArrFromSet(ingrSet) {
  const ingridients = new Set(ingrSet);
  for(let ingridient of ingridients) {
    if(!ingridient.nutrValuesW) {
      ingridients.delete(ingridient);
    }
  }
  return Array.from(ingridients);
}