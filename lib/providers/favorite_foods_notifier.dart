import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/food.dart';

class FavoriteFoodsNotifier extends StateNotifier<List<Food>>{
  FavoriteFoodsNotifier() : super([]);

  bool toggleFoodFavoriteStatus(Food food){
    final foodIsFavorite = state.contains(food);

    if (foodIsFavorite){
      state = state
          .where(
            (element) => element.id != food.id ,
      ).toList();
      return false;
    }else{
      state = [...state, food];
      return true;
    }
  }
}

final favoriteFoodProvider =
    StateNotifierProvider<FavoriteFoodsNotifier, List<Food>>(
      (ref) {
        return FavoriteFoodsNotifier();
      },
    );