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

export function nutrValues100(nutrValues1) {
  return nutrValues1.map(item => +(item * 100).toFixed(2));
} 