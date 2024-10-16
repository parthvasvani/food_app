import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/foods_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) {
    return FilterNotifier();
  },
);

final filterFoodProvider = Provider(
  (ref) {
    final foods = ref.watch(foodsProvider);
    final activeFilters = ref.watch(filterProvider);
    return foods.where((food) {
      if (activeFilters[Filter.glutenFree]! && !food.isGlutenFree){
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !food.isLactoseFree){
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !food.isVegetarian){
        return false;
      }
      if (activeFilters[Filter.vegan]! && !food.isVegan){
        return false;
      }
      return true;
    },
    ).toList();
  },
);
