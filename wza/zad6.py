
class NK:
    k = 1 # Default value of k
    def __init__(self, *args):
        
        if len(args) == 1 and isinstance(args[0], list):            
            self.tuples = args[0]
        else:
            self.tuples = list(args)
        
        if len(self.tuples) != NK.k:
            raise ValueError("Number of elements in tuple must be equal to k")
        
    def __le__(self, other):
        # compare all of the elements in tuple
        for i in range(NK.k):
            if self.tuples[i] > other.tuples[i]:
                return False
        return True

    def set_k(k):
        NK.k = k

    def __str__(self):
        return str(self.tuples)

    def __repr__(self):
        return str(self.tuples)

    # function witch returns the set of minimal elements from subset of NK
    @staticmethod
    def minimal_elements(A):
        M = set()
        for a in A:
            is_minimal = True
            M_copy = M.copy()
            for m in M_copy:
                if m <= a:
                    is_minimal = False
                    break
                if a <= m:
                    M.remove(m)

            if is_minimal:
                M.add(a)

        return M


# Test
if __name__ == "__main__":
    # {(n.k) e N^2: (n - 10)^2 + (k - 10)^2 <= 25}
    NK.set_k(2)
    A = {NK(n, k) for n in range(0, 16) for k in range(0, 16) if (n - 10)**2 + (k - 10)**2 <= 25}
    M = NK.minimal_elements(A)

    print(f"A = {A}")
    print(f"M = {M}")